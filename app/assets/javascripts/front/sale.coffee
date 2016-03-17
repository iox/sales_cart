$ ->
  new FastClick(document.body)

  items = []
  window.addItem = (id, name, price, out_of_stock = false) ->
    if out_of_stock
      return alert('This item is out of stock')

    items.push
      id: id
      name: name
      price: price
    updateCart()

  window.updateCart = ->
    $('.cart-row').remove()
    rows = ""
    for item,index in items
      rows += "<tr class='cart-row'>
        <td class='name'>#{item.name}</td>
        <td class='text-right price'>kr. #{item.price}</td>
        <td><a class='btn' onclick='removeItem(#{index}); return false'>X</a></td>
      </tr>"
    $('#cart-table').prepend(rows)

    total = items.reduce ((total, item) -> total + item.price), 0
    $('#total').html("kr. #{total}")


  window.removeItem = (index) ->
    items.splice(index, 1)
    updateCart()

  window.pay = () ->
    $.post("/sales", {rows: JSON.stringify(items)}, ->
      items = []
      $('.alert-success').show().fadeOut(2000)
      updateCart()
    ).fail (data) ->
      console.log(data.responseJSON.errors)
      alert("Error: #{data.responseJSON.errors}")
