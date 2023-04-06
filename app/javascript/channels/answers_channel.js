import consumer from "./consumer"

consumer.subscriptions.create({
      channel: "AnswersChannel",
      question_id: gon.question_id
    }, {
  connected() {
    console.log('Answers channel connected.');
    this.perform('follow');
  },
  received(data) {
      console.log('fsfsdf');
    if (gon.user_id === data.answer.author_id) return;

    const template = require('./handlebars/answer.hbs');

    data.is_question_owner = gon.user_id === gon.current_user_id;

    $('.answers').append(template(data));
  }
});
