$ ->
  new FastClick(document.body)

  localStorage.sales ||= JSON.stringify []

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
    # Load localStorage, add the new sale and save it
    sales = JSON.parse(localStorage.sales)
    sales.push(items)
    localStorage.sales = JSON.stringify(sales)

    # Clean up the form for the next sale
    items = []
    updateCart()

    $('.alert-success').show().fadeOut(2000)
    updateQueueStatus()


  window.updateQueueStatus = ->
    console.log("updateQueueStatus")
    sales = JSON.parse(localStorage.sales)
    if sales.length > 0
      $("#queue_status").html "#{sales.length} sale(s) in queue"
      $("#queue_status").show()
    else
      $("#queue_status").html("All sales are synced with the server")
      $("#queue_status").show().fadeOut(5000)


  updateQueueStatus()
  setInterval ->
    sales = JSON.parse(localStorage.sales)

    for sale in sales

      $.post("/sales", {rows: JSON.stringify(sale)}, ->
        indexOfSale = sales.indexOf(sale)
        sales.splice(indexOfSale)
        localStorage.sales = JSON.stringify(sales)

      ).fail (data) ->
        console.log("Error: could not send the sale to the server. Retrying in 5 seconds.")
        if data.responseJSON && data.responseJSON.errors
          alert("Error: #{data.responseJSON.errors}")

      updateQueueStatus()
  , 5000



