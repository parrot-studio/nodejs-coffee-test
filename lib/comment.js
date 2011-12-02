var Comment;

Comment = (function() {

  function Comment(name, body) {
    this.name = name;
    this.body = body;
  }

  Comment.prototype.say = function() {
    return "" + this.name + " " + this.body;
  };

  return Comment;

})();

exports.Comment = Comment;
