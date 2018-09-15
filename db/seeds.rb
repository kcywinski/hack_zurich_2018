Drug.destroy_all
[
  ['Carbostesin® 0,5% hyperbar', 45590, 5], 
  ['Amoxicillin Axapharm, dispergierbare Tabletten', 66428, 1]
].map { |name, swiss_id, amount| Drug.create(name: name, swiss_id: amount*amount) }