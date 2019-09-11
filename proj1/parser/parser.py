import csv
import os
from xml.sax import handler, make_parser


class Handler(handler.ContentHandler):
    def __init__(self, pub_file, pub_authors_file):
        handler.ContentHandler.__init__(self)

        self.subPublication = ['article', 'book', 'incollection', 'masterthesis',
                               'inproceedings', 'proceedings', 'phdthesis']

        self.fields = ['pubid', 'pubtype', 'mdate', 'pubkey',
                       'crossref', 'journal', 'year', 'month', 'title']
        self.pubId = 0
        self.attrs = {}
        self.authors = []
        self.content = ''

        self.fpub = open(pub_file, 'w')
        self.fpub_authors = open(pub_authors_file, 'w')
        self.pub_writer = csv.writer(self.fpub)
        self.pub_authors_writer = csv.writer(self.fpub_authors)

    def startDocument(self):
        self.pub_writer.writerow(self.fields)
        self.pub_authors_writer.writerow(['pubid', 'author'])

    def startElement(self, name, attrs):
        if name in self.subPublication:
            mdate, key = attrs.getValue('mdate'), attrs.getValue('key')
            self.pubId += 1
            self.attrs = {'pubid': self.pubId,
                          'pubtype': name, 'mdate': mdate, 'pubkey': key}
            self.authors = []

        # if name == 'author':

    def endElement(self, name):
        if name in self.subPublication:
            self.write_pub(self.attrs)
            self.write_authors()
        if name in self.fields:
            self.attrs[name] = self.content
        if name == 'author':
            self.authors.append(self.content)

        self.content = ''

    def characters(self, content):
        if content.strip():
            self.content = content

    def write_pub(self, attrs):
        row = [attrs.get(field, None) for field in self.fields]
        self.pub_writer.writerow(row)

    def write_authors(self):
        rows = [[self.pubId, author] for author in self.authors]
        self.pub_authors_writer.writerows(rows)

    def endDocument(self):
        self.fpub.close()
        self.fpub_authors.close()


if __name__ == '__main__':
    if not os.path.exists('out'):
        os.mkdir('out')
    pub_file, pub_authors_file, = os.path.join(
        'out', 'pub.csv'), os.path.join('out', 'pub_authors.csv'),
    parser = make_parser()
    dblp_handler = Handler(pub_file, pub_authors_file)
    parser.setContentHandler(dblp_handler)
    parser.parse('/Users/caoliu/Desktop/temp.xml')
