SELECT o.amount * s.commission / 100 from salesperson s, order o where o.sales_id = s.id
