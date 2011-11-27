$ ->
  $("img").click (e) ->
    audio = $("audio")[0]
    audio.currentTime = e.offsetX / e.target.width * audio.duration
