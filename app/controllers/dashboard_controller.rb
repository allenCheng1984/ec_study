class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    @dimension = params[:dimension] || 'month'
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

  # 銷售小組頁
  def sales_intro
  end

  def sales_model_training
  end

  def sales_conclusion
  end

  # 評價小組頁
  def review_intro
  end

  def review_model_training
  end

  def review_conclusion
  end

  # 物流小組頁
  def logistics_intro
  end

  def logistics_model_training
  end

  def logistics_conclusion
  end

  private

    def set_index_orders(dimension, date_range)
      return Order.where(order_purchase_year: '2017')         if dimension == 'year'  && !date_range
      return Order.where(order_purchase_year_month: '201712') if dimension == 'month' && !date_range
      return Order.where(order_purchase_yearweek: '201748')   if dimension == 'week'  && !date_range

      return Order.where(order_purchase_year: date_range)       if dimension == 'year'  && date_range
      return Order.where(order_purchase_year_month: date_range) if dimension == 'month' && date_range
      return Order.where(order_purchase_yearweek: date_range)   if dimension == 'week'  && date_range

      return []
    end
end
