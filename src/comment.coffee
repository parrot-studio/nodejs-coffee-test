class Comment
  constructor: (@name, @body) ->

  say: -> "#{@name} #{@body}"

exports.Comment = Comment
