require 'api/defaults'

module API
  module Constructor
    module Edit
      class QuestionData < Grape::API
        include Defaults
        format :json

        #authorize! send_error: true

        params do
          requires :question_id, type: String
          requires :title, type: String
          requires :sub_title, type: String
          requires :answers_type, type: String
          requires :answers, type: String
          requires :true_answers, type: String
          requires :finished, type: Boolean
          optional :image, type: File
        end

        patch 'question_data' do
          content_type 'multipart/form-data'

          question_t = QuestionTemplate.find_by(id: params[:question_id])

          raise 'Question not exists!' unless question_t

          answers = JSON.parse(params[:answers]).values
          true_answers = JSON.parse(params[:true_answers])
          image = params[:image]

          question_t.update!(
              title: params[:title],
              subtitle: params[:sub_title],
              true_answers: true_answers,
              answers: answers,
              data: {
                  answers_type: params[:answers_type],
              }
          )

          if image
            attachment = {
                filename: image[:filename],
                type: image[:type],
                headers: image[:head],
                tempfile: image[:tempfile]
            }

            question_t.title_image = ActionDispatch::Http::UploadedFile.new(attachment)
          end

          if params[:finished]
            test_t = question_t.test_template
            test_t.status = :created
            test_t.set_options
            test_t.save!
          end

          sleep 3
          {}
        rescue => error
          error!(error, 400)
        end
      end
    end
  end
end