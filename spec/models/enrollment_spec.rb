require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe '#is_past_application_deadline' do
    let(:deadline) { Date.today }
    let(:trimester) do
      Trimester.create!(
        year: '2025',
        term: 'Spring',
        application_deadline: deadline,
        start_date: deadline - 30,
        end_date: deadline + 60
      )
    end
    let(:course) { Course.create!(trimester: trimester, coding_class: CodingClass.create!(title: 'Ruby')) }

    context 'when enrollment is created before the deadline' do
      it 'returns false' do
        enrollment = Enrollment.create!(course: course,
                                        student: Student.create!(first_name: 'Sally', last_name: 'Giraffe', email: 'sally@example.com'), created_at: deadline - 1)
        expect(enrollment.is_past_application_deadline).to eq(false)
      end
    end

    context 'when enrollment is created after the deadline' do
      it 'returns true' do
        enrollment = Enrollment.create!(course: course,
                                        student: Student.create!(first_name: 'Ben', last_name: 'Giraffe', email: 'ben@example.com'), created_at: deadline + 1)
        expect(enrollment.is_past_application_deadline).to eq(true)
      end
    end
  end
end
