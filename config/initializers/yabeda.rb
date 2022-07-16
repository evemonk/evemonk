# frozen_string_literal: true

Yabeda.configure do
  group :evemonk do
    counter :esi_requests_200_counter, comment: "Total number of ESI requests with status 200", tags: [:total]
    counter :esi_requests_201_counter, comment: "Total number of ESI requests with status 201", tags: [:total]
    counter :esi_requests_204_counter, comment: "Total number of ESI requests with status 204", tags: [:total]
    counter :esi_requests_304_counter, comment: "Total number of ESI requests with status 304", tags: [:total]
    counter :esi_requests_400_counter, comment: "Total number of ESI requests with status 400", tags: [:total]
    counter :esi_requests_401_counter, comment: "Total number of ESI requests with status 401", tags: [:total]
    counter :esi_requests_403_counter, comment: "Total number of ESI requests with status 403", tags: [:total]
    counter :esi_requests_404_counter, comment: "Total number of ESI requests with status 404", tags: [:total]
    counter :esi_requests_420_counter, comment: "Total number of ESI requests with status 420", tags: [:total]
    counter :esi_requests_500_counter, comment: "Total number of ESI requests with status 500", tags: [:total]
    counter :esi_requests_502_counter, comment: "Total number of ESI requests with status 502", tags: [:total]
    counter :esi_requests_503_counter, comment: "Total number of ESI requests with status 503", tags: [:total]
    counter :esi_requests_504_counter, comment: "Total number of ESI requests with status 504", tags: [:total]
  end
end
