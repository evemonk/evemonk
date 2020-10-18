# frozen_string_literal: true

Yabeda.configure do
  group :evemonk do
    counter :esi_requests_200_counter, comment: "Total number of ESI requests with status 200"
    counter :esi_requests_204_counter, comment: "Total number of ESI requests with status 204"
    counter :esi_requests_304_counter, comment: "Total number of ESI requests with status 304"
    counter :esi_requests_400_counter, comment: "Total number of ESI requests with status 400"
    counter :esi_requests_401_counter, comment: "Total number of ESI requests with status 401"
    counter :esi_requests_403_counter, comment: "Total number of ESI requests with status 403"
    counter :esi_requests_404_counter, comment: "Total number of ESI requests with status 404"
    counter :esi_requests_420_counter, comment: "Total number of ESI requests with status 420"
    counter :esi_requests_500_counter, comment: "Total number of ESI requests with status 500"
    counter :esi_requests_503_counter, comment: "Total number of ESI requests with status 503"
    counter :esi_requests_504_counter, comment: "Total number of ESI requests with status 504"
  end
end
