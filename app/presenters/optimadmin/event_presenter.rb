module Optimadmin
  class EventPresenter < Optimadmin::BasePresenter
    presents :event
    delegate :event_location, to: :event_location

    def name
      event.name
    end

    def toggle_title
      inline_detail_toggle_link(name)
    end

    def event_agendas
      h.link_to h.pluralize(event.event_agendas.count, "agenda"), h.event_agendas_path(event_id: event.id)
    end

    def event_bookings
      h.link_to h.pluralize(event.event_bookings_count, "booking"), h.event_event_bookings_path(event)
    end

    def location
      event.event_location.location_name
    end

    def description
      h.raw event.description
    end
  end
end
