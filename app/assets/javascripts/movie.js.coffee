# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.my_jsonp_callbacks = {}
window.my_jsonp_script_tags = {}

append_jsonp_script_tag = (my_callback, url)->
  uid = (new Date()).getTime();
  window.my_jsonp_callbacks[uid] = (json_response)->
    delete window.my_jsonp_callbacks[uid]
    my_callback(json_response)
    debugger    

  # add the script tag to the document, cross fingers
  url += "?jsonp=" + encodeURIComponent("my_jsonp_callbacks[" + uid + "]")
  my_jsonp_script_tag = document.createElement('script')
    .setAttribute('src', url)
    .setAttribute('type', 'text/javascript')
    .setAttribute('data-id', uid)
  body_tag = document.getElementsByTagName('body')[0]
  body_tag.appendChild(my_jsonp_script_tags[uid])

update_actor_list = (list_item_data)->
  list_elem = document.getElementById('actor-list')
  list_item_elems = list_elem.getElementsByTagName('dt')
  for cur_item in [0...list_item_data.length]
    do (cur_item)->
      if cur_item < list_item_elems.length
        list_item_elems[cur_item].firstChild.data = list_item_data[cur_item].name
        list_item_elems[cur_item].setAttribute("data-id", list_item_data[cur_item].id)
      else
        dt = document.createElement('dt')
        txt = document.createTextNode(list_item_data[cur_item].name)
        debugger
        dt.appendChild(txt)
        list_elem.appendChild(dt)
        dt.setAttribute("data-id",list_item_data[cur_item].id)

  if list_item_data.length < list_item_elems.length
    for cur_item in [list_item_data.length...list_item_elems.length]
      do (cur_item)->
        list_elem.removeChild(list_item_elems[cur_item])

update_list = (user_event) ->
  user_event.stopPropagation()
  id = user_event.target.dataset['id']
  switch user_event.currentTarget.id
    when "movie-list"
      append_jsonp_script_tag(update_actor_list, id + "/actors.js")
    when "actor-list"
      append_jsonp_script_tag(update_movie_list, id + "/movies.js")
    else
      debugger

my_load = () ->
  document.getElementById('movie-list').addEventListener('click', update_list, true)
  document.getElementById('actor-list').addEventListener('click', update_list, true)

window.addEventListener("load", my_load, false)

