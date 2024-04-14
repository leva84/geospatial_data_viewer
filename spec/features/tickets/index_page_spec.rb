# frozen_string_literal: true

feature 'Tickets index page', type: :feature do
  let!(:tickets) { create_list(:ticket, 3) }

  scenario 'User views the tickets index page' do
    # Переходим на страницу с тикетами
    visit root_path

    # Проверяем заголовок страницы
    expect(page).to have_css('h2', text: 'Tickets')

    # Проверяем наличие таблицы
    expect(page).to have_css('table.table')

    # Проверяем наличие заголовков столбцов
    expect(page).to have_css('th', text: '№')
    expect(page).to have_css('th', text: 'Id')
    expect(page).to have_css('th', text: 'Request number')
    expect(page).to have_css('th', text: 'Request type')
    expect(page).to have_css('th', text: 'Request action')
    expect(page).to have_css('th', text: 'Response due date time')
    expect(page).to have_css('th', text: '')

    # Проверяем наличие данных в таблице
    tickets.reverse.each_with_index do |ticket, i|
      n = i + 1
      expect(page).to have_css("tr:nth-child(#{ n }) td", text: n)
      expect(page).to have_css("tr:nth-child(#{ n }) td", text: ticket.id)
      expect(page).to have_css("tr:nth-child(#{ n }) td", text: ticket.request_number)
      expect(page).to have_css("tr:nth-child(#{ n }) td", text: ticket.request_type)
      expect(page).to have_css("tr:nth-child(#{ n }) td", text: ticket.request_action)
      expect(page).to have_css("tr:nth-child(#{ n }) td", text: ticket.response_due_date_time)

      # Проверяем наличие кнопки для просмотра деталей тикета
      expect(page).to have_link(href: ticket_path(ticket)) do |link|
        expect(link).to have_css('span.bi.bi-eye')
      end
    end
  end
end
