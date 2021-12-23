class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    @dimension = params[:dimension] || 'year'
    @date_range = params[:date_range] || nil

    @orders = set_index_orders(@dimension, @date_range)
    @orders_payments_sum = @orders.map{|order| order.total_payment_value }.sum
  end

  def team_members
  end

  def about
  end

  def predict
  end

  def dataset_info
  end

  private

    def set_index_orders(dimension, date_range)
      orders = Order.where(order_purchase_year: '2018')         if dimension == 'year'  && !date_range
      orders = Order.where(order_purchase_year_month: '201810') if dimension == 'month' && !date_range
      orders = Order.where(order_purchase_yearweek: '201842')   if dimension == 'week'  && !date_range

      orders = Order.where(order_purchase_year: date_range)       if dimension == 'year'  && date_range
      orders = Order.where(order_purchase_year_month: date_range) if dimension == 'month' && date_range
      orders = Order.where(order_purchase_yearweek: date_range)   if dimension == 'week'  && date_range

      orders
    end
end
