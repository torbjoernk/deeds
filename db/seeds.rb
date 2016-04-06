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

haa = Collection.create(
    title: 'Herzoglich Arenbergisches Archiv',
    abbr: 'HAA',
    storages: [vest]
)
raise 'Collection not saved' unless haa.persisted?

raise 'Storage and Collection not linked' unless vest.collections.include? haa

haa_r3a3_original = Document.create(
    title: 'Urkunde, Reihe III, Nr. 3',
    document_type: 'original',
    collections: [haa]
)
raise 'Document not saved' unless haa_r3a3_original.persisted?
raise 'Document and Collection not linked' unless haa.documents.include? haa_r3a3_original


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

reitersiegel_otto = Seal.create(
    title: 'Reitersiegel des Grafen Otto von Dale',
    material: 'wax',
    attachment_type: 'hinging'
)
raise 'Seal not saved' unless reitersiegel_otto.persisted?

haa_r3a3 = Deed.create(
    title: 'Urkunde Reihe III, Nr. 3',
    year: 1226,
    description: 'Der Abt des Klosters Knechtsteden bezeugt, dass der Prior G. und Richmodis, die verstorbene Vorsteherin des Klosters Flaesheim, von Simon von Gemen ein Landgut in Hamm erworben haben.',
    content: dummy_content,
    documents: [haa_r3a3_original],
    seal: reitersiegel_otto
)
raise 'Deed not saved' unless haa_r3a3.persisted?
raise 'Deed and Document not linked' unless haa_r3a3_original.deed == haa_r3a3
raise 'Deed and Content not linked' unless dummy_content.deed == haa_r3a3
raise 'Deed and Seal not linked' unless reitersiegel_otto.deed == haa_r3a3

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


gottschalk_prior = Mention.create(
    person: gottschalk,
    place: kloster_knechtsteden,
    role: prior,
    deed: haa_r3a3
)
raise 'Mention not saved' unless gottschalk_prior.persisted?

gottschalk_kaeufer = Mention.create(
    person: gottschalk,
    role: kaeufer,
    deed: haa_r3a3
)
raise 'Mention not saved' unless gottschalk_kaeufer.persisted?

richmodis_flaesheim = Mention.create(
    person: richmodis,
    place: kloster_flaesheim,
    role: klostervorsteher,
    deed: haa_r3a3
)
raise 'Mention not saved' unless richmodis_flaesheim.persisted?

richmodis_kaeufer = Mention.create(
    person: richmodis,
    role: kaeufer,
    deed: haa_r3a3
)
raise 'Mention not saved' unless richmodis_kaeufer.persisted?

simon_landgut = Mention.create(
    person: simon,
    place: landgut_hamm,
    role: besitzer,
    deed: haa_r3a3
)
raise 'Mention not saved' unless simon_landgut.persisted?

simon_verkaeufer = Mention.create(
    person: simon,
    role: verkaeufer,
    deed: haa_r3a3
)
raise 'Mention not saved' unless simon_verkaeufer.persisted?

velkere_zeuge = Mention.create(
    person: velkere,
    role: zeuge,
    deed: haa_r3a3
)
raise 'Mention not saved' unless velkere_zeuge.persisted?


pennings_h = Reference.create(
    title: 'Die Anfänge des Stiftes Flaesheim',
    authors: 'Pennings, Heinrich',
    container: 'Vestische Zeitschrift 36, S. 1-56',
    year: 1929,
    notes: 'leicht gekürzter Wiederabdruck in: Grochtmann, Hermann (Hrsg.), Flaesheim. Zur 800-Jahrfeier (1166-1966), Münster, o.J.[1966], S. 116-146'
)
raise 'Reference not saved' unless pennings_h.persisted?

pennings_1 = Reference.create(
    title: 'Geschichte der Stadt Recklinghausen und ihrer Umgebung, Bnd. 1',
    authors: 'Pennings, Heinrich',
    place: 'Recklinghausen',
    year: 1930
)
raise 'Reference not saved' unless pennings_1.persisted?
