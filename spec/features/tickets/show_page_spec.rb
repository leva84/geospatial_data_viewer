feature 'Show Ticket Details', type: :feature do
  let(:ticket) { create(:ticket) }
  let(:excavator) { ticket.excavator }

  scenario 'User views ticket details' do
    visit ticket_path(ticket)

    # Проверка заголовка страницы
    expect(page).to have_css('h2', text: 'Ticket Details')

    # Проверка информации о тикете
    expect(page).to have_css('.card-title', text: 'Ticket Information')
    expect(page).to have_css('p', text: "Ticket ID: #{ ticket.id }")
    expect(page).to have_css('p', text: "Request Number: #{ ticket.request_number }")
    expect(page).to have_css('p', text: "Sequence Number: #{ ticket.sequence_number }")
    expect(page).to have_css('p', text: "Request Type: #{ ticket.request_type }")
    expect(page).to have_css('p', text: "Request Action: #{ ticket.request_action }")
    expect(page).to have_css('p', text: "Response Due Date Time: #{ ticket.response_due_date_time }")
    expect(page).to have_css('p', text: "Primary Service Area Code: #{ ticket.primary_service_area_code }")
    expect(page).to have_css('p', text: "Additional Service Area Codes: #{ ticket.additional_service_area_codes }")

    # Проверка информации об экскаваторе
    expect(page).to have_css('.card-title', text: 'Excavator Information')
    expect(page).to have_css('p', text: "Ticket ID: #{ excavator.id }")
    expect(page).to have_css('p', text: "Company_Name: #{ excavator.company_name }")
    expect(page).to have_css('p', text: 'Crew On Site:')

    # Проверить map
    expect(page).to have_selector('div#map')
  end
end
