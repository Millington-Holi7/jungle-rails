class Admin::DashboardController < ApplicationController
  
  def show
    @product_count = Product.count
    @category_count = Category.count
    puts "INDEX ACTION CALLED. Product count: #{@product_count}"
 end
end

