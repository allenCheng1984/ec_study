class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    @dimension = params[:dimension] || 'month'
    @date_range = params[:date_range] || nil

    @orders = set_index_orders(@dimension, @date_range)
    @orders_payments_sum = @orders.map{|order| order.total_payment_value }.sum

    @sales_trend_chart_data        = set_sales_trend_chart_data(@orders, @dimension)
    @sale_by_categories_chart_data = set_sale_by_categories_chart_data(@orders)
    @heat_map_chart_data           = set_heat_map_chart_data(@orders)
    @dount_chart_data              = set_dount_chart_data(@orders)
    @seller_rank_data              = set_seller_rank_data(@orders)
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

    def set_sales_trend_chart_data(orders, dimension)
      columns = case dimension
        when 'year'
          orders.map{|p| p.order_purchase_month }.uniq.sort
        when 'month'
          orders.map{|p| p.order_purchase_date }.uniq.sort
        when 'week'
          orders.map{|p| p.order_purchase_dayofweek }.uniq.sort
        end

      data = []
      columns.each do |column|
        value = case dimension
        when 'year'
          orders.filter{|p| p.order_purchase_month == column }.sum(&:total_payment_value)
        when 'month'
          orders.filter{|p| p.order_purchase_date == column }.sum(&:total_payment_value)
        when 'week'
          orders.filter{|p| p.order_purchase_dayofweek == column }.sum(&:total_payment_value)
        end

        data << { country: set_column_name(column, dimension), visits: value }
      end

      return data.to_json
    end

    def set_sale_by_categories_chart_data(orders)
    end

    def set_heat_map_chart_data(orders)
    end

    def set_dount_chart_data(orders)
    end

    def set_seller_rank_data(orders)
    end

    def set_column_name(column, dimension)
      if dimension == 'week'
        name = case column
                when 0; '星期日'
                when 1; '星期一'
                when 2; '星期二'
                when 3; '星期三'
                when 4; '星期四'
                when 5; '星期五'
                when 6; '星期六'
                end
      end

      if dimension == 'year'
        name = case column
                when 1; '一月'
                when 2; '二月'
                when 3; '三月'
                when 4; '四月'
                when 5; '五月'
                when 6; '六月'
                when 7; '七月'
                when 8; '八月'
                when 9; '九月'
                when 10; '十月'
                when 11; '十一月'
                when 12; '十二月'
                end
      end

      return name || column.to_s
    end

end
