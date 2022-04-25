class UserStocksController < ApplicationController
    def create
        stock = Stock.check_db(params[:ticker])
        if stock.blank?
            stock = Stock.new_lookup(params[:ticker])
            stock.save
            @user_stock = UserStock.create(user: current_user, stock: stock)
            flash[:notice] = "Stock #{stock.name} was successfully added"
            redirect_to my_portfolio_path
        end
    end

    def destroy
        stock = Stock.find(params[:id])
        user_stock = UserStock.where(user_id: current_user, stock_id: stock.id)
        user_stock.destroy
        flash[:notice] = "#{stock.name} was successfully removed from portfolio"
        redirect_to my_portfolio_path
    end
end
