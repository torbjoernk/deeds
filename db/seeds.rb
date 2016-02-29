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
    storages: [
      vest
    ]
)
raise 'Archive not saved' unless haa.persisted?

raise 'Storage and Archive not linked' unless vest.archives.include? haa

haa_r3a3_original = Source.create(
    title: 'Urkunde, Reihe III, Nr. 3',
    source_type: 'original',
    archives: [ haa ]
)
raise 'Source not saved' unless haa_r3a3_original.persisted?
raise 'Source and Archive not linked' unless haa.sources.include? haa_r3a3_original

haa_r3a3_transcript = Source.create(
    title: 'Urkunde, Reihe III, Nr. 3',
    source_type: 'transcript'
)
raise 'Source not saved' unless haa_r3a3_transcript.persisted?
