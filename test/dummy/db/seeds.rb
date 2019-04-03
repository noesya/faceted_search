c1 = Category.find_or_create_by title: "Category 1"
c2 = Category.find_or_create_by title: "Category 2"
c3 = Category.find_or_create_by title: "Category 3"

c1a = Category.find_or_create_by title: "Sub-category 1A", parent_id: c1.id
c1b = Category.find_or_create_by title: "Sub-category 1B", parent_id: c1.id
c1b1 = Category.find_or_create_by title: "Sub-Sub-category 1B1", parent_id: c1b.id
c2a = Category.find_or_create_by title: "Sub-category 2A", parent_id: c2.id
c3a = Category.find_or_create_by title: "Sub-category 3A", parent_id: c3.id

k1 = Kind.find_or_create_by title: "Kind 1"
k2 = Kind.find_or_create_by title: "Kind 2"
k3 = Kind.find_or_create_by title: "Kind 3"

p1 = Product.find_or_create_by title: "Product 1"
p2 = Product.find_or_create_by title: "Product 2"
p3 = Product.find_or_create_by title: "Product 3"
p4 = Product.find_or_create_by title: "Product 4"

i1 = Item.find_or_create_by title: "Item 1"
i1.categories = [c1]
i1.products = [p1]
i1.kinds = [k2]

i2 = Item.find_or_create_by title: "Item 2"
i2.products = [p3, p2]
i2.categories = [c3, c3a]

i3 = Item.find_or_create_by title: "Item 3"
i3.categories = [c2]

i4 = Item.find_or_create_by title: "Item 4"
i4.kinds = [k1, k3]
i4.categories = [c2, c2a]

i5 = Item.find_or_create_by title: "Item 5"
i5.kinds = [k1]
i5.products = [p1, p2]

i6 = Item.find_or_create_by title: "Item 6"
i6.categories = [c2, c2a]

i7 = Item.find_or_create_by title: "Item 7"
i7.categories = [c2, c2a, c1, c1b, c1b1]

i8 = Item.find_or_create_by title: "Item 8"
i8.categories = [c1, c1a]
i8.kinds = [k1]

i9 = Item.find_or_create_by title: "Item 9"
i9.kinds = [k2]
i9.products = [p3]
i9.categories = [c3, c3a]