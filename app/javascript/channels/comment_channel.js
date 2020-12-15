import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = 
    `<div class="comment">
      <div>${data.user}</div>
      <div>${data.time}</div>
      <div>${data.text.content}</div>
    </div>`;
    const comments = document.getElementById('comments_list');
    const newComment = document.getElementById('comment_content');
    comments.insertAdjacentHTML('beforeend', html);
    newComment.value='';
    const form = document.getElementById('comment_submit');
    form.removeAttribute("disabled");
  }
});
