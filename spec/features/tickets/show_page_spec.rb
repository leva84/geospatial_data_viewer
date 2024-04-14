# frozen_string_literal: true

feature 'Show Ticket Details', type: :feature do
  let(:ticket) { create(:ticket) }
  let(:excavator) { ticket.excavator }

  scenario 'User views ticket details' do
    visit ticket_path(ticket)

    # Проверка заголовка страницы
    expect(page).to have_css('h2', text: 'Ticket Details')

    # Проверка информации о тикете
    expect(page).to have_css('.card-title', text: 'Ticket Information')
    expect(page).to have_css('p', text: "#{ Ticket.human_attribute_name(:id) }: #{ ticket.id }")
    expect(page)
      .to have_css('p', text: "#{ Ticket.human_attribute_name(:request_number) }: #{ ticket.request_number }")
    expect(page)
      .to have_css('p', text: "#{ Ticket.human_attribute_name(:sequence_number) }: #{ ticket.sequence_number }")
    expect(page)
      .to have_css('p', text: "#{ Ticket.human_attribute_name(:request_type) }: #{ ticket.request_type }")
    expect(page)
      .to have_css('p', text: "#{ Ticket.human_attribute_name(:request_action) }: #{ ticket.request_action }")
    expect(page)
      .to have_css('p', text: "#{ Ticket.human_attribute_name(:response_due_date_time) }: #{ ticket.response_due_date_time }")
    expect(page)
      .to have_css('p', text: "#{ Ticket.human_attribute_name(:primary_service_area_code) }: #{ ticket.primary_service_area_code }")
    expect(page)
      .to have_css('p', text: "#{ Ticket.human_attribute_name(:additional_service_area_codes) }: #{ ticket.additional_service_area_codes }")

    # Проверка информации об экскаваторе
    expect(page).to have_css('.card-title', text: 'Excavator Information')
    expect(page).to have_css('p', text: "#{ Excavator.human_attribute_name(:id) }: #{ excavator.id }")
    expect(page).to have_css('p', text: "#{ Excavator.human_attribute_name(:company_name) }: #{ excavator.company_name }")
    expect(page).to have_css('p', text: "#{ Excavator.human_attribute_name(:company_name) }: ")

    # Проверить map
    expect(page).to have_selector('div#map')
  end
end
