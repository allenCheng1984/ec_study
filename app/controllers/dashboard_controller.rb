class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    @dimension = params[:dimension] || 'month'
    @date_range = params[:date_range] || nil

    @orders = set_index_orders(@dimension, @date_range)
    @orders_payments_sum = @orders.map{|order| order.total_payment_value }.sum

    @sales_trend_chart_data        = set_sales_trend_chart_data(@orders, @dimension)
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

    # 圖表 data: 銷售趨勢
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

    # 圖表 data: 購買頻率(依時間)
    def set_heat_map_chart_data(orders)
      return [
        {
          "hour": "12pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 0 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "1am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 1 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "2am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 2 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "3am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 3 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "4am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 4 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "5am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 5 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "6am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 6 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "7am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 7 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "8am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 8 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "9am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 9 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "10am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 10 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "11am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 11 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "12am",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 12 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "1pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 13 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "2pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 14 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "3pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 15 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "4pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 16 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "5pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 17 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "6pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 18 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "7pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 19 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "8pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 20 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "9pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 21 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "10pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 22 && order.order_purchase_dayofweek == 0}.count
        },
        {
          "hour": "11pm",
          "weekday": "Sun",
          "value": orders.filter{ |order| order.order_purchase_hour == 23 && order.order_purchase_dayofweek == 0}.count
        },

        # Mon ---------
        {
          "hour": "12pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 0 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "1am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 1 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "2am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 2 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "3am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 3 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "4am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 4 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "5am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 5 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "6am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 6 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "7am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 7 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "8am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 8 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "9am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 9 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "10am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 10 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "11am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 11 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "12am",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 12 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "1pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 13 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "2pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 14 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "3pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 15 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "4pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 16 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "5pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 17 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "6pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 18 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "7pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 19 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "8pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 20 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "9pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 21 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "10pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 22 && order.order_purchase_dayofweek == 1}.count
        },
        {
          "hour": "11pm",
          "weekday": "Mon",
          "value": orders.filter{ |order| order.order_purchase_hour == 23 && order.order_purchase_dayofweek == 1}.count
        },

        # Tue ---------
        {
          "hour": "12pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 0 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "1am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 1 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "2am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 2 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "3am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 3 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "4am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 4 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "5am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 5 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "6am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 6 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "7am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 7 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "8am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 8 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "9am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 9 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "10am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 10 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "11am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 11 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "12am",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 12 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "1pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 13 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "2pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 14 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "3pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 15 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "4pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 16 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "5pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 17 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "6pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 18 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "7pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 19 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "8pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 20 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "9pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 21 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "10pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 22 && order.order_purchase_dayofweek == 2}.count
        },
        {
          "hour": "11pm",
          "weekday": "Tue",
          "value": orders.filter{ |order| order.order_purchase_hour == 23 && order.order_purchase_dayofweek == 2}.count
        },

        # Wed ---------
        {
          "hour": "12pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 0 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "1am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 1 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "2am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 2 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "3am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 3 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "4am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 4 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "5am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 5 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "6am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 6 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "7am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 7 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "8am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 8 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "9am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 9 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "10am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 10 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "11am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 11 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "12am",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 12 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "1pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 13 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "2pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 14 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "3pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 15 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "4pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 16 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "5pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 17 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "6pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 18 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "7pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 19 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "8pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 20 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "9pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 21 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "10pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 22 && order.order_purchase_dayofweek == 3}.count
        },
        {
          "hour": "11pm",
          "weekday": "Wed",
          "value": orders.filter{ |order| order.order_purchase_hour == 23 && order.order_purchase_dayofweek == 3}.count
        },

        # The ---------
        {
          "hour": "12pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 0 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "1am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 1 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "2am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 2 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "3am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 3 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "4am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 4 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "5am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 5 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "6am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 6 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "7am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 7 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "8am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 8 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "9am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 9 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "10am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 10 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "11am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 11 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "12am",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 12 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "1pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 13 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "2pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 14 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "3pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 15 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "4pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 16 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "5pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 17 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "6pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 18 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "7pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 19 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "8pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 20 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "9pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 21 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "10pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 22 && order.order_purchase_dayofweek == 4}.count
        },
        {
          "hour": "11pm",
          "weekday": "Thu",
          "value": orders.filter{ |order| order.order_purchase_hour == 23 && order.order_purchase_dayofweek == 4}.count
        },

        # Fri ---------
      {
          "hour": "12pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 0 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "1am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 1 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "2am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 2 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "3am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 3 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "4am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 4 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "5am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 5 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "6am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 6 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "7am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 7 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "8am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 8 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "9am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 9 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "10am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 10 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "11am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 11 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "12am",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 12 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "1pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 13 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "2pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 14 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "3pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 15 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "4pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 16 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "5pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 17 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "6pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 18 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "7pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 19 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "8pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 20 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "9pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 21 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "10pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 22 && order.order_purchase_dayofweek == 5}.count
        },
        {
          "hour": "11pm",
          "weekday": "Fri",
          "value": orders.filter{ |order| order.order_purchase_hour == 23 && order.order_purchase_dayofweek == 5}.count
        },

        # Sat ---------
        {
          "hour": "12pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 0 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "1am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 1 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "2am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 2 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "3am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 3 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "4am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 4 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "5am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 5 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "6am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 6 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "7am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 7 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "8am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 8 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "9am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 9 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "10am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 10 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "11am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 11 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "12am",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 12 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "1pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 13 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "2pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 14 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "3pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 15 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "4pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 16 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "5pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 17 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "6pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 18 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "7pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 19 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "8pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 20 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "9pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 21 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "10pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 22 && order.order_purchase_dayofweek == 6}.count
        },
        {
          "hour": "11pm",
          "weekday": "Sat",
          "value": orders.filter{ |order| order.order_purchase_hour == 23 && order.order_purchase_dayofweek == 6}.count
        },
      ].to_json
    end

    # 圖表 data: 銷售比例
    def set_dount_chart_data(orders)
      columns = orders.map{|p| p.item_category_name }.uniq.sort
      data = []

      columns.each do |column|
        value = orders.filter{|p| p.item_category_name == column }.sum(&:total_payment_value)
        data << { name: column, value: value }
      end

      return data.sort_by{|obj| obj[:value]}.reverse[0..4].to_json
    end

    # 圖表 data: 城市銷售排名
    def set_seller_rank_data(orders)
      columns = orders.map{|p| p.seller_city }.uniq.compact
      data = []

      columns.each do |column|
        value = orders.filter{|p| p.seller_city == column }.sum(&:total_payment_value)
        data << { country: column, value: value }
      end

      filtered_data = data.sort_by{|obj| obj[:value]}.reverse[0..9]
      return filtered_data.sort_by{|obj| obj[:value]}.to_json
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
