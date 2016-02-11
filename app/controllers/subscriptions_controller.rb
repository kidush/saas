class SubscriptionsController < ApplicationController

  before_action :authenticate_user!

  def new
    @plans = Plan.all
  end

  def edit
    @account = Account.find(params[:id])
    @plans = Plan.all
  end

  def index
    @account = Account.find_by_email(current_user.email)
  end

  def create

    token = params[:stripeToken]
    plan = params[:plan][:stripe_id]
    email = current_user.email
    current_account = Account.find_by_email(current_user.email)
    customer_id = current_account.customer_id
    current_plan = current_account.stripe_plan_id

    if customer_id.nil?
      # Nuovo customer
      # Genero la sottoscrizione nel mio account Stripe
      @customer = Stripe::Customer.create(
          :source => token,
          :plan => plan,
          :email => email
      )
      subscriptions  = @customer.subscriptions
      @subscribed_plan = subscriptions.data.find { |o| o.plan.id == plan }
    else
      # Estraggo customer da Stripe
      @customer = Stripe::Customer.retrieve(customer_id)
      @subscribed_plan = create_or_update_subscription(@customer, current_plan, plan)
    end
    # Estraggo il periodo - questo dato è in UNIX timestamp format
    current_period_end = @subscribed_plan.current_period_end
    # converto il dato
    active_until = Time.at(current_period_end).to_datetime
    # Richiamo il metodo SAVE_ACCOUNT_DETAILS
    save_account_details(current_account, plan, @customer.id, active_until)
    redirect_to :root, :notice => "Sottoscrizione effettuata con successo"
  rescue => e
    redirect_to :back, :flash => {:error => e.message}
  end

  def update_card

  end

  def update_card_details
    token = params[:stripeToken]
    current_account = Account.find_by_email(current_user.email)
    customer_id = current_account.customer_id

    customer = Stripe::Customer.retrieve(customer_id)

    customer.source = token
    customer.save

    redirect_to '/subscriptions', :notice => "Carta di credito aggiornata con successo"

  rescue => e
    redirect_to :action => 'update_card', :flash => {:error => e.message}

  end


  #
  #   GENERAL METHOD
  #

  def cancel_subscription
    current_account = Account.find_by_email(current_user.email)
    customer_id = current_account.customer_id
    current_plan = current_account.stripe_plan_id

    if current_plan.blank?
      raise "Nessun abboamento da annullare"
    end

    customer = Stripe::Customer.retrieve(customer_id)

    subscriptions = customer.subscriptions

    current_subscribed_plan = subscriptions.data.find{ |o| o.plan.id == current_plan }

    if current_subscribed_plan.blank?
      raise "Abbonamento non trovato"
    end

    current_subscribed_plan.delete

    save_account_details(current_account, nil, customer_id, Time.at(0).to_datetime)

    @message = "Abbonamento cancellato con successo"

  rescue => e
    redirect_to '/subscriptions', :flash => {:error => e.message}

  end


  def save_account_details(account, plan, customer_id, active_until)
    account.stripe_plan_id = plan
    account.customer_id = customer_id
    account.active_until = active_until
    account.save!
  end


  def create_or_update_subscription(customer, current_plan, new_plan)
    subscriptions = customer.subscriptions
    # Trovo l'abbonamento attuale
    current_subscription = subscriptions.data.find { |o| o.plan.id == current_plan }
    if current_subscription.blank?
      # Nessun abbonamento presente quindi crearne uno nuovo
      subscription = customer.subscriptions.create({:plan => new_plan})
    else
      # Con un abbonamento presente, effettuare aggiornamento
      current_subscription.plan = new_plan
      subscription = current_subscription.save
    end
    return subscription
  end


end
