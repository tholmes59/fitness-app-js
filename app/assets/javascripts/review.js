function Review(review) {
    this.id = review.id
    this.content = review.content;
    this.rating = review.rating;
    this.reviewer = review.reviewer;
    this.createAt = new Date(review.create_at);
}

