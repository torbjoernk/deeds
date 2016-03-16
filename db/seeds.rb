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

dummy_translation = ContentTranslation.create(
    language: 'latin',
    translation: 'Quo vadis?',
    content: dummy_content
)
raise 'ContentTranslation not saved' unless dummy_translation.persisted?

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

kloster_knechtsteden = Place.create(
    title: 'Kloster Knechtsteden'
)
raise 'Place not saved' unless kloster_knechtsteden.persisted?

kloster_flaesheim = Place.create(
    title: 'Kloster Flaesheim'
)
raise 'Place not saved' unless kloster_flaesheim.persisted?

landgut_hamm = Place.create(
    title: 'Landgut in Hamm'
)
raise 'Place not saved' unless landgut_hamm.persisted?

gottschalk = Person.create(
    name: 'Gottschalk',
    gender: 'male'
)
raise 'Person not saved' unless gottschalk.persisted?

richmodis = Person.create(
    name: 'Richmodis',
    gender: 'female'
)
raise 'Person not saved' unless richmodis.persisted?

simon = Person.create(
    name: 'Simon von Gemen',
    gender: 'male'
)
raise 'Person not saved' unless simon.persisted?

velkere = Person.create(
    name: 'Eberhard Velkere',
    gender: 'male'
)
raise 'Person not saved' unless velkere.persisted?


kaeufer = Role.create(
    title: 'Käufer',
    referring: 'deed'
)
raise 'Role not saved' unless kaeufer.persisted?

prior = Role.create(
    title: 'Prior',
    referring: 'place'
)
raise 'Role not saved' unless prior.persisted?

klostervorsteher = Role.create(
    title: 'Klostervorsteher',
    referring: 'place'
)
raise 'Role not saved' unless klostervorsteher.persisted?

besitzer = Role.create(
    title: 'Besitzer',
    referring: 'place'
)
raise 'Role not saved' unless besitzer.persisted?

verkaeufer = Role.create(
    title: 'Verkäufer',
    referring: 'deed'
)
raise 'Role not saved' unless verkaeufer.persisted?

zeuge = Role.create(
    title: 'Zeuge',
    referring: 'deed'
)
raise 'Role not saved' unless zeuge.persisted?
