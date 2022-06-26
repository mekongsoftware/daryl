
-- vwOrder view
select 
	o.RestaurantId, o.orderId, TableName = t.NameEn, p.[Sequence], 
	ProductName = p.NameVi, ProductPrice = op.Price, 
	AddonName = a.NameVi, AddonPrice = opa.Price,
	o.OrderAmount, o.TotalAmount, o.TipAmount
from [Order] o
left join [OrderProduct] op on op.OrderId = o.OrderId
left join [OrderProductAddon] opa on opa.OrderProductId = op.OrderProductId
left join [Product] p on p.ProductId = op.ProductId
left join [Addon] a on a.AddonId = opa.AddonId
left join [Table] t on t.TableId = o.TableId



/*
select * from [Order]
select * from [OrderProduct]
select * from [OrderProductAddon]


delete [OrderProductAddon]
delete [OrderProduct]
delete [Order]