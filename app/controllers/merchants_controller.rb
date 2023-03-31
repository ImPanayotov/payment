class MerchantsController < ApplicationController
  def index
    merchants = Merchant.all

    render 'merchants/index',
           locals: { merchants: }
  end

  def show
    merchant = find_merchant
    transactions = merchant.transactions
                           .includes(:customer)
                           .order(id: :desc)

    render 'merchants/show',
           locals: { merchant:,
                     transactions: }
  end

  def new
    merchant = Merchant.new

    render 'merchants/new',
           locals: { merchant: }
  end

  def edit
    merchant = find_merchant

    render 'merchants/edit',
           locals: { merchant: }
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to merchant_path(merchant),
                  notice: 'Merchant successfully created!'
    else
      render 'merchants/new',
             locals: { merchant: }
    end
  end

  def update
    merchant = find_merchant

    if merchant.update(merchant_params)
      redirect_to merchant_path(merchant),
                  notice: 'Merchant successfully updated!'
    else
      render 'merchants/edit',
             locals: { merchant: }
    end
  end

  def destroy
    merchant = find_merchant

    merchant.destroy
    redirect_to merchants_path,
                flash: { notice: 'Merchant was successfully removed!' }
  end

  private

  def find_merchant
    Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant)
          .permit(merchant_attrs)
  end

  def merchant_attrs
    action_name == 'create' ? create_merchant_attrs : update_merchant_attrs
  end

  def update_merchant_attrs
    %i[name
       email
       status
       description
       total_transaction_sum]
  end

  def create_merchant_attrs
    update_merchant_attrs + %i[password password_confirmation]
  end
end
