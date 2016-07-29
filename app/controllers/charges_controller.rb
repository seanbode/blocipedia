class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1500,
      description: "Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
    )
    if charge.paid == true
      current_user.premium!
    end

    flash[:notice] = "Thank you for your patronage, #{current_user.email}!"
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Blocipedia Membership - #{current_user.email}",
      amount: 1500
    }
  end

  def destroy
    current_user.standard!

    current_user.wikis.update_all(private: false) 
    redirect_to user_path(current_user)
  end
end
