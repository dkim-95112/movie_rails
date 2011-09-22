# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.my_jsonp_callbacks = {}

update_list_elems = (list_elem_id, list_item_data, data_field)->
  # update list
  list_elem = document.getElementById(list_elem_id)
  list_item_elems = list_elem.getElementsByTagName('dt')
  for cur_item in [0...list_item_data.length]
    do (cur_item)->
      if cur_item < list_item_elems.length
        # update existing
        list_item_elems[cur_item].firstChild.data = list_item_data[cur_item][data_field]
        list_item_elems[cur_item].setAttribute("data-id", list_item_data[cur_item].id)
      else
        # add new
        dt = document.createElement('dt')
        txt = document.createTextNode(list_item_data[cur_item][data_field])
        dt.appendChild(txt)
        list_elem.appendChild(dt)
        dt.setAttribute("data-id",list_item_data[cur_item].id)

  if list_item_data.length < list_item_elems.length
    # remove extra
    for cur_item in [list_item_data.length...list_item_elems.length]
      do (cur_item)->
        list_elem.removeChild(list_item_elems[cur_item])

append_jsonp_script_tag = (list_elem_id, url, data_field)->

  # setup jsonp callback
  uid = (new Date()).getTime();
  window.my_jsonp_callbacks[uid] = (json_response)->
    delete window.my_jsonp_callbacks[uid]
    update_list_elems(list_elem_id, json_response, data_field)

    # callback finished so remove script tag
    body_tag = document.getElementsByTagName('body')[0]
    script_tag = body_tag.getElementsByTagName('script')[0]
    debugger if parseInt(script_tag.dataset.id) != uid  # sanity
    body_tag.removeChild(script_tag)

  # add the script tag to the document, cross fingers
  url += "?jsonp=" + encodeURIComponent("my_jsonp_callbacks[" + uid + "]")
  my_jsonp_script_tag = document.createElement('script')
  for k,v of {src: url, type:'text/javascript', 'data-id': uid}
    my_jsonp_script_tag.setAttribute(k,v) 
  body_tag = document.getElementsByTagName('body')[0]
  body_tag.appendChild(my_jsonp_script_tag)

update_list = (user_event) ->
  user_event.stopPropagation()
  data_id = user_event.target.dataset.id
  switch user_event.currentTarget.id
    when "movie-list"
      append_jsonp_script_tag("actor-list", data_id + "/actors.js", "name")
    when "actor-list"
      append_jsonp_script_tag("movie-list", "/actor/" + data_id + "/movies.js", "title")
    else
      debugger  # sanity

my_load = () ->
  document.getElementById('movie-list').addEventListener('click', update_list, true)
  document.getElementById('actor-list').addEventListener('click', update_list, true)

window.addEventListener("load", my_load, false)

