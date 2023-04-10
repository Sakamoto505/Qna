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
        // Поиск элемента по атрибуту data-answer-id


        const answerElem = $('.answers').find(`[id="${data.answer.id}"]`);
        console.log(answerElem)
        // Проверка, существует ли элемент уже на странице
        if (answerElem.length === 0) {
            const template = require('../../views/handlebars/answer.hbs');
            data.is_question_owner = gon.user_id === gon.current_user_id;
            $('.answers').append(template(data));
        }
    }

    });
