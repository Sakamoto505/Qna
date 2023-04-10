import consumer from "./consumer";

$('form[id*="new-comment"]').on('ajax:success', function(e) {
    var comment = e.detail[0][0].comment;

    if (comment && comment.commentable_type && comment.commentable_id && comment.body) {
        $('.' + comment.commentable_type.toLowerCase() + ' .comments-' + comment.commentable_id + ' ul').append('<li>' + comment.body + '</li>');

        this.querySelector('#comment_body').value = '';
        $('.' + comment.commentable_type.toLowerCase() + ' .comments-' + comment.commentable_id + ' .comments-errors').empty();
    } else {
        console.error('Invalid comment object:', comment);
    }
}).on('ajax:error', function(e) {
    var comment = e.detail[0][0].comment;

    if (comment && comment.commentable_type && comment.commentable_id) {
        $('.' + comment.commentable_type.toLowerCase() + ' .comments-' + comment.commentable_id + ' .comments-errors').empty();

        var errors = e.detail[0][0].errors;

        $.each(errors, function(index, value) {
            $('.' + comment.commentable_type.toLowerCase() + ' .comments-' + comment.commentable_id + ' .comments-errors').append('<p>' + value + '</p>');
        });
    } else {
        console.error('Invalid comment object:', comment);
    }
});

    consumer.subscriptions.create('CommentsChannel', {
        connected() {
            this.perform('follow');
        },

        received(data) {
            if(gon.user_id !== data.user_id) {
                $('.' + data.commentable_type.toLowerCase() + ' .comments-' + data.commentable_id + ' ul').append('<li>' + data.comment + '</li>');
            }
        }
    })
