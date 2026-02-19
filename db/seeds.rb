# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

num_sections = 6
num_authors = 10
num_articles = 90
num_static_pages = 4

Magazine.create(
    title: Faker::Hipster.sentence(word_count: 3).delete_suffix('.'),
    description: Faker::Hipster.sentence(word_count: 3, supplemental: false, random_words_to_add: 5).delete_suffix('.'),
    color_1: "#523F70",
    color_2: "#D1C8E1",
    color_3: "#222251",
    color_4: "#98C1D9",
    pages_order: []
)

num_sections.times do
    Section.create(
        title: Faker::Hipster.sentence(word_count: 1, supplemental: false, random_words_to_add: 1).delete_suffix('.')
    )
end

num_authors.times do
    Author.create(
        name: Faker::Name.name,
        bio: Faker::Hipster.paragraph(sentence_count: 2)
    )
end

num_articles.times do
    content = Faker::Hipster.paragraphs(number: 6).join('</div><div>')
    content = "<div>" + content + "<div>"
    published = rand(10) > 2 ? true : false
    Article.create(
        title: Faker::Hipster.sentence(word_count: 3, supplemental: false, random_words_to_add: 5).delete_suffix('.'),
        dek: Faker::Hipster.sentence(word_count: 6, supplemental: false, random_words_to_add: 12).delete_suffix('.'),
        content: content,
        author_id: rand(1...Author.count),
        section_id: rand(1...Section.count),
        published: published
    )
end

num_static_pages.times do
    content = Faker::Hipster.paragraphs(number: 5).join('</p><p>')
    content = "<p>" + content + "</p>"
    Article.create(
        title: Faker::Hipster.sentence(word_count: 1, supplemental: false, random_words_to_add: 1).delete_suffix('.'),
        dek: Faker::Hipster.sentence(word_count: 8, supplemental: false, random_words_to_add: 12).delete_suffix('.'),
        content: content,
        author_id: nil,
        section_id: nil,
        published: true,
        static_page: true
    )
end
