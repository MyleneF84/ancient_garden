import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-image"
export default class extends Controller {
  static values = { imageId: String }

  remove() {
    const thumbnailContainer = this.element.closest('.image-thumbnail');

    // Remove the thumbnail from the DOM
    thumbnailContainer.remove();

    // Send AJAX request to delete the attachment
    fetch(`/admins/products/${this.imageIdValue}/delete_image_attachement`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Failed to delete attachment');
      }
      return response.json();
    })
    .then(data => {
      console.log('Attachment deleted successfully');
    })
    .catch(error => {
      console.error(error.message);
      // Handle error
    });
  }
}
