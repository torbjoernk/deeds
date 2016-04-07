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

vz = Collection.create(
    title: 'Vestische Zeitschrift',
    abbr: 'VZ'
)
raise 'Collection not saved' unless vz.persisted?

rek2 = Collection.create(
    title: 'Die Regesten der Erzbischöfe von Köln im Mittelalter, Bnd. 2: 1100-1205',
    abbr: 'REK 2',
    notes: 'bearb. von Richard Kipping, Bonn 1901 (ND Düsseldorf 1985)'
)
raise 'Collection not saved' unless rek2.persisted?

wub2 = Collection.create(
    title: 'Regesta Historiae Westfaliae. Accedit Codex Diplomaticus, Bd. 2',
    abbr: 'WUB 2'
)
raise 'Collection not saved' unless wub2.persisted?

wub7 = Collection.create(
    title: 'Westfälisches Urkunden-Buch, Bnd. 7',
    abbr: 'WUB 7'
)
raise 'Collection not saved' unless wub7.persisted?


haa_r3n3_original = Document.create(
    title: 'Urkunde, Reihe III, Nr. 3',
    document_type: 'original',
    collections: [haa]
)
raise 'Document not saved' unless haa_r3n3_original.persisted?
raise 'Document and Collection not linked' unless haa.documents.include? haa_r3n3_original

haa_r3n3_druck = Document.create(
    title: "#{haa_r3n3_original.title} nach Or.",
    document_type: 'print',
    collections: [wub7]
)
raise 'Document not saved' unless haa_r3n3_druck.persisted?
raise 'Document and Collection not linked' unless wub7.documents.include? haa_r3n3_druck

haa_r3n3_content = Content.create(
    language: 'latin',
    content: 'In nomino sacte et individue Trinitatis. Ego G. divina misericordia Knetstedensis ecclisie minister humilies onibus hoc scriptum...'
)
raise 'Content not saved' unless haa_r3n3_content.persisted?

haa_r3n3_translation = ContentTranslation.create(
    language: 'contemporary_german',
    translation: 'Im Name der heiligen und unteilbaren Dreifaltigkeit. Ich, G(ottschalk), durch göttliche Barmherzigkeit unbedeutender Diener der Kirche von Knechtsteden, allen, die dieses Schriftstück einsehen werden, bis in alle Ewigkeit. Weil gewöhnlich dem Gedächtnis entfällt, was nicht durch den Zusammenhang der Buchstaben bekräftigt worden ist, haben wir es also für angemessen gehalten, eurer Klostergemeinschaft zu bekunden, dass der Prior G. und die Klostervorsteherin R., seligen Angedenkens, in Flaesheim, die sich in allen Dingen gut um die Schwestern gekümmert und besonders wegen der Kleidung gewissenhafte Softfalt an den Tag gelegt haben, mit reifer und frommer Einsicht ein Landgut in Hamm, das am Fest des heiligen Martin ein Malter Roggen und zwölf Denare einbringt, zusammen mit den Leibeigenen und dem übrigen Zubehör von den Almosen ihrer Freunde aus der Hand des Simon von Gemen für neun Mark erworben und mit unserer Vollmacht und Zustimmung der Einleidung ihrer Schwestern zugedacht haben. Damit also diese Tatsache bei unseren Nachfahren unangetastet und unerschüttert bleibt, haben wir es für richtig gehalten, dass dies durch den Schutz des Bannes und unseres Siegels bekräftigt werden müsse. Zeugen sind: Rabbodo, Prior in Knechtsteden, der Küster Ricolf, der Priester God., der Priester Hermann aus Recklinghausen, der Priester Ludwig aus Datteln, der Priester Thomas aus Haltern, der Priester Goswin aus Ramsdorf, Hermann aus Hervest, der Priester Gottschalk aus Hamm, Eberhard Velkere, Ritter Brunstein, Gerlach Bitter, Hermann Irsutus, Alexander aus Leven, Rudolf wie auch viele andere. Dies wurde im Jahr 1226 seit der Menschwerdung des Herrn verhandelt.',
    content: haa_r3n3_content
)
raise 'ContentTranslation not saved' unless haa_r3n3_translation.persisted?


haa_r3n3 = Deed.create(
    title: haa_r3n3_original.title,
    year: 1226,
    description: 'Der Abt des Klosters Knechtsteden bezeugt, dass der Prior G. und Richmodis, die verstorbene Vorsteherin des Klosters Flaesheim, von Simon von Gemen ein Landgut in Hamm erworben haben.',
    content: haa_r3n3_content,
    documents: [haa_r3n3_original, haa_r3n3_druck]
)
raise 'Deed not saved' unless haa_r3n3.persisted?
raise 'Deed and Document not linked' unless haa_r3n3_original.deed == haa_r3n3
raise 'Deed and Document not linked' unless haa_r3n3_druck.deed == haa_r3n3
raise 'Deed and Content not linked' unless haa_r3n3_content.deed == haa_r3n3

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


gottschalk_prior = Mention::MentionEntry.create(
    person: gottschalk,
    place: kloster_knechtsteden,
    role: prior,
    deed: haa_r3n3
)
raise 'MentionEntry not saved' unless gottschalk_prior.persisted?

gottschalk_kaeufer = Mention::MentionEntry.create(
    person: gottschalk,
    role: kaeufer,
    deed: haa_r3n3
)
raise 'MentionEntry not saved' unless gottschalk_kaeufer.persisted?

richmodis_flaesheim = Mention::MentionEntry.create(
    person: richmodis,
    place: kloster_flaesheim,
    role: klostervorsteher,
    deed: haa_r3n3
)
raise 'MentionEntry not saved' unless richmodis_flaesheim.persisted?

richmodis_kaeufer = Mention::MentionEntry.create(
    person: richmodis,
    role: kaeufer,
    deed: haa_r3n3
)
raise 'MentionEntry not saved' unless richmodis_kaeufer.persisted?

simon_landgut = Mention::MentionEntry.create(
    person: simon,
    place: landgut_hamm,
    role: besitzer,
    deed: haa_r3n3
)
raise 'MentionEntry not saved' unless simon_landgut.persisted?

simon_verkaeufer = Mention::MentionEntry.create(
    person: simon,
    role: verkaeufer,
    deed: haa_r3n3
)
raise 'MentionEntry not saved' unless simon_verkaeufer.persisted?

velkere_zeuge = Mention::MentionEntry.create(
    person: velkere,
    role: zeuge,
    deed: haa_r3n3
)
raise 'MentionEntry not saved' unless velkere_zeuge.persisted?


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

siegelbuch = Reference.create(
    title: 'Die Westfälischen Siegel des Mittelalters',
    year: 1900,
    place: 'Münster',
    notes: 'Mit Unterstützung der Landstände der Provinz hrsg. vom Verein für Geschichte und Altertumskunde Westfalens, Münster 1882-1900'
)
raise 'Reference not saved' unless siegelbuch.persisted?


haa_r3n3.references << pennings_h
haa_r3n3.references << pennings_1
haa_r3n3.save!
raise 'Deed and References not linked' unless haa_r3n3.references.include? pennings_h


haa_r3n7_original = Document.create(
    title: 'Urkunde, Reihe III, Nr. 7',
    document_type: 'original',
    collections: [haa]
)
raise 'Document not saved' unless haa_r3n7_original.persisted?

haa_r3n7_druck = Document.create(
    title: "#{haa_r3n7_original.title} nach Or.",
    document_type: 'print',
    collections: [wub7]
)
raise 'Document not saved' unless haa_r3n7_druck.persisted?

haa_r3n7 = Deed.create(
    title: haa_r3n7_original.title,
    year: 1252,
    month: 8,
    day: 13,
    description: 'Der Kölner Erzbischof Konrad I. von Hochstaden teilt mit, dass Ludewicus aus Waltrop eine Hufe seines Allods in Waltrop dem Kloser Flaesheim überlässt.',
    documents: [haa_r3n7_original, haa_r3n7_druck],
    references: [pennings_h]
)
raise 'Deed not saved' unless haa_r3n7.persisted?

konrad_siegel = Seal.create(
    title: 'erzbischöfliches Thronsiegel des Konrad I. von Hochstaden',
    attachment_type: 'hinging',
    deed: haa_r3n7
)
raise 'Seal not saved' unless konrad_siegel.persisted?


otto_siegel = Seal.create(
    title: 'Thronsiegel Ottos II. zur Lippe, Bischof von Münster',
    attachment_type: 'silk',
    references: [siegelbuch]
)
raise 'Seal not saved' unless otto_siegel.persisted?
