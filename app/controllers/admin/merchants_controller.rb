class Admin
  class MerchantsController < AdminController
    def index
      merchants = Merchant.all

      authorize(merchants)

      render 'merchants/index',
             locals: { merchants: merchants }
    end

    def show
      merchant = find_merchant

      authorize(merchant)

      transactions = merchant.transactions
                             .includes(:customer)
                             .order(id: :desc)

      render 'merchants/show',
             locals: { merchant: merchant,
                       transactions: transactions }
    end

    def edit
      merchant = find_merchant

      authorize(merchant)

      render 'merchants/edit',
             locals: { merchant: merchant }
    end

    def update
      merchant = find_merchant

      authorize(merchant)

      if merchant.update(merchant_params)
        redirect_to admin_merchant_path(merchant),
                    notice: 'Merchant successfully updated!'
      else
        render 'merchants/edit',
               locals: { merchant: merchant }
      end
    end

    def new
      merchant = Merchant.new

      authorize(merchant)

      render 'merchants/new',
             locals: { merchant: merchant }
    end

    def create
      merchant = Merchant.new(merchant_params)

      authorize(merchant)

      if merchant.save
        redirect_to admin_merchant_path(merchant),
                    notice: 'Merchant successfully created!'
      else
        render 'merchants/new',
               locals: { merchant: merchant }
      end
    end

    def destroy
      merchant = find_merchant

      authorize(merchant)

      merchant.destroy

      notice = if merchant.errors.present?
                 merchant.errors.full_messages.to_sentence
               else
                 'Merchant was successfully removed!'
               end

      redirect_to admin_merchants_path,
                  flash: { notice: }
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
end
