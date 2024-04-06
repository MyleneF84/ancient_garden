class AdminsController < ApplicationController
  before_action :authenticate_user!

  # une classe ruby qui prend
  # qui va exposer beaucoup de methode d'instance
  # chaque methode peut etre en one line OU
  # peut contenir une logique groupee : par exemple def fulfillment_ratio
  # - ne pas hesiter a utiliser le pattern ||=
  # comme  @orders_by_day ||= Order.where("created_at > ?",  7.days.ago).order(:id)

  # tout ce qui est utilisé dans la vue ==> methode publique
  # le reste ==> methode private

  def home
    @orders = Order.where(fulfilled: false).order(created_at: :desc).limit(10)
    @quick_stats = {
      sales: Order.where(created_at: Time.current.beginning_of_day..Time.now).count,
      revenue: Order.where(created_at: Time.current.midnight..Time.now).sum(:total),
      avg_sale: Order.where(created_at: Time.current.midnight..Time.now).average(:total),
      per_sale: OrderProduct.joins(:order).where(orders: {created_at: Time.now.midnight..Time.now }).average(:quantity)
    }
    @orders_by_day = Order.where(created_at: 7.days.ago..).order(:id)
    @orders_by_day = @orders_by_day.group_by { |order| order.created_at.to_date }
    @revenue_by_day = @orders_by_day.map { |day, orders| [day.strftime("%A"), orders.sum(&:total)] }

    if @revenue_by_day.count < 7
      days_of_week = Date::DAYNAMES

      data_hash = @revenue_by_day.to_h
      current_day = Date.current.strftime("%A")
      current_day_index = days_of_week.index(current_day)
      next_day_index = (current_day_index + 1 ) % days_of_week.length

      ordered_days_with_current_last = days_of_week[next_day_index..-1] + days_of_week[0..next_day_index]

      complete_ordered_array_with_current_last = ordered_days_with_current_last.map { |day| [day, data_hash.fetch(day, 0)] }

      @revenue_by_day = complete_ordered_array_with_current_last
    end

    @best_selling = OrderProduct.group(:product_id).order('SUM(quantity) DESC').sum(:quantity)
    @best_selling = @best_selling.map { |k, v| [Product.find(k).name, v] }


    total = 0
    fulfilled = 0
    unfulfilled = 0

    @fulfillement_ratio = @orders_by_day.map do |day, orders|

      fulfilled_count = orders.count { |o| o.fulfilled } + fulfilled
      unfulfilled_count = orders.count { |p| !p.fulfilled } + unfulfilled

      orders.each do |order|
        total += 1
        order.fulfilled ? fulfilled += 1 : unfulfilled += 1
      end

      [day.strftime("%A"), (fulfilled_count * 100.0 / total).round, (unfulfilled_count * 100.0 / total).round]
    end
  end
end
