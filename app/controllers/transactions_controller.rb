class TransactionsController < ApplicationController
  # GET /transactions
  # GET /transactions.json
  def index
    if current_user.is_not_council?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.json
  def new
            
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @transaction = Transaction.new(params[:transaction])
    @transaction_from = Transaction.new
    @transaction_from.amount = -@transaction.amount
    @transaction_from.user = current_user

    respond_to do |format|
      if (@transaction.amount > 0) && (current_user.account_value >= @transaction.amount) && @transaction.save && @transaction_from.save
        format.html { redirect_to user_path(current_user), notice: 'Account balance was successfully transferred.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    if current_user.is_not_council?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :ok }
    end
  end
end
