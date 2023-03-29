class CustomersController < ApplicationController
  def index
    customers = Customer.all

    authorize(customers)

    render 'customers/index',
           locals: { customers: customers }
  end

  def show
    customer = find_customer

    authorize(customer)

    transactions = customer.transactions.includes(:merchant).order(id: :desc)

    render 'customers/show',
           locals: { customer: customer,
                     transactions: transactions }
  end

  def edit
    customer = find_customer

    authorize(customer)

    render 'customers/edit',
           locals: { customer: customer }
  end

  def update
    customer = find_customer

    authorize(customer)

    if customer.update(customer_params)
      redirect_to customer_path(customer),
                  notice: 'Customer successfully updated!'
    else
      render 'customers/edit',
             locals: { customer: customer }
    end
  end

  def new
    customer = Customer.new

    authorize(customer)

    render 'customers/new',
           locals: { customer: customer }
  end

  def create
    customer = Customer.new(customer_params)

    authorize(customer)

    if customer.save
      redirect_to customer_path(customer),
                  notice: 'Customer successfully created!'
    else
      render 'customers/new',
             locals: { customer: customer }
    end
  end

  def destroy
    customer = find_customer

    authorize(customer)

    customer.destroy
    redirect_to customers_path,
                flash: { notice: 'Customer was successfully removed!' }
  end

  private

  def find_customer
    Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer)
          .permit(customer_attrs)
  end

  def customer_attrs
    action_name == 'create' ? create_customer_attrs : update_customer_attrs
  end

  def update_customer_attrs
    %i[first_name
       last_name
       phone
       email
       total_transaction_sum]
  end

  def create_customer_attrs
    update_customer_attrs + %i[password password_confirmation]
  end
end
