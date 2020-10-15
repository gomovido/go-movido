export default function datepicker() {
  const input = $('.datepicker')
  if (input) {
    input.flatpickr({dateFormat: "d-m-Y"})
  }
}




