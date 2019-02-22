c1 = Category.find_or_create_by title: "Category 1"
c2 = Category.find_or_create_by title: "Category 2"
c3 = Category.find_or_create_by title: "Category 3"

k1 = Kind.find_or_create_by title: "Kind 1"
k2 = Kind.find_or_create_by title: "Kind 2"
k3 = Kind.find_or_create_by title: "Kind 3"

p1 = Product.find_or_create_by title: "Product 1"
p2 = Product.find_or_create_by title: "Product 2"
p3 = Product.find_or_create_by title: "Product 3"

i1 = Item.find_or_create_by title: "Item 1"
i1.categories = [c1]
i1.products = [p1]
i1.kinds = [k2]

i2 = Item.find_or_create_by title: "Item 2"
i2.products = [p3, p2]

i3 = Item.find_or_create_by title: "Item 3"
i3.categories = [c2]

i4 = Item.find_or_create_by title: "Item 4"
i4.kinds = [k1, k3]

i5 = Item.find_or_create_by title: "Item 5"
i5.kinds = [k1]
i5.products = [p1, p2]

i6 = Item.find_or_create_by title: "Item 6"
i6.categories = [c3]
