class MerchantsController < ApplicationController
  def index
    merchants = Merchant.all

    render 'merchants/index',
           locals: { merchants: merchants }
  end

  def show
    merchant = find_merchant
    transactions = merchant.transactions

    render 'merchants/show',
           locals: { merchant: merchant,
                     transactions: transactions }
  end

  def edit
    merchant = find_merchant

    render 'merchants/edit',
           locals: { merchant: merchant }
  end

  def update
    merchant = find_merchant

    if merchant.update(merchant_params)
      redirect_to merchant_path(merchant),
                  flash: { notice: 'Merchant successfully updated!' }
    else
      render 'merchants/edit',
             locals: { merchant: merchant }
    end
  end

  def new
    merchant = Merchant.new

    render 'merchants/new',
           locals: { merchant: merchant }
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to merchant_path(merchant),
                  notice: 'Merchant successfully created!'
    else
      render 'merchants/new',
             locals: { merchant: merchant }
    end
  end

  def destroy
    merchant = find_merchant

    merchant.destroy
    redirect_to merchants_path,
                notice: 'Merchant was successfully removed!'
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
    %i[name
       email
       status
       description
       total_transaction_sum]
  end
end
