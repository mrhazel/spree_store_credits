Spree::OrderUpdater.class_eval do 

  def update_totals
    update_payment_total
    update_item_total
    update_shipment_total
    update_adjustment_total
    update_order_total
  end



  def update_adjustment_total
    recalculate_adjustments
    order.adjustment_total = line_items.sum(:adjustment_total) +
                             shipments.sum(:adjustment_total)  +
                             adjustments.eligible.sum(:amount)
    order.included_tax_total = line_items.sum(:included_tax_total) + shipments.sum(:included_tax_total)
    order.additional_tax_total = line_items.sum(:additional_tax_total) + shipments.sum(:additional_tax_total)

    order.promo_total = line_items.sum(:promo_total) +
                        shipments.sum(:promo_total) +
                        adjustments.promotion.eligible.sum(:amount)
  end

  def update_shipment_total
    order.shipment_total = shipments.sum(:cost)
  end


end