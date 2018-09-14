[
  ['Headache drug', 42], 
  ['Sleeping pills', 13]
].map { |name, amount| Drug.create(name: name, amount_left: amount, swissmedic_id: amount*amount) }