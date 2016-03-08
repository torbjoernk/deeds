# coding; UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vest = Storage.create(
    title: 'Stadt- und Vestisches Archiv Recklinghausen'
)
raise 'Storage not saved' unless vest.persisted?

haa = Archive.create(
    title: 'Herzoglich Arenbergisches Archiv',
    abbr: 'HAA',
    storages: [vest]
)
raise 'Archive not saved' unless haa.persisted?

raise 'Storage and Archive not linked' unless vest.archives.include? haa

haa_r3a3_original = Source.create(
    title: 'Urkunde, Reihe III, Nr. 3',
    source_type: 'original',
    archives: [haa]
)
raise 'Source not saved' unless haa_r3a3_original.persisted?
raise 'Source and Archive not linked' unless haa.sources.include? haa_r3a3_original


dummy_content = Content.create(
    language: 'contemporary_german',
    content: 'Hello World'
)
raise 'Content not saved' unless dummy_content.persisted?


haa_r3a3 = Deed.create(
    title: 'Urkunde, Reihe III, Nr. 3',
    year: 1226,
    description: 'Der Abt des Klosters Knechtsteden bezeugt, dass der Prior G. und Richmodis, die verstorbene Vorsteherin des Klosters Flaesheim, von Simon von Gemen ein Landgut in Hamm erworben haben.',
    notes: 'nur eine Notiz',
    content: dummy_content,
    sources: [haa_r3a3_original]
)
raise 'Deed not saved' unless haa_r3a3.persisted?
raise 'Deed and Source not linked' unless haa_r3a3_original.deed == haa_r3a3
raise 'Deed and Content not linked' unless dummy_content.deed == haa_r3a3
