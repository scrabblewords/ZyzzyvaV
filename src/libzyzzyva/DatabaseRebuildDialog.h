//---------------------------------------------------------------------------
// DatabaseRebuildDialog.h
//
// A dialog for specifying lexicon databases to be rebuilt.
//
// Copyright 2015 Twilight Century Computing.
// Copyright 2008-2012 North American SCRABBLE Players Association.
//
// This file is part of Zyzzyva.
//
// Zyzzyva is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// Zyzzyva is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//---------------------------------------------------------------------------

#ifndef ZYZZYVA_DATABASE_REBUILD_DIALOG_H
#define ZYZZYVA_DATABASE_REBUILD_DIALOG_H

#include <QDialog>
#include <QRadioButton>

class LexiconSelectWidget;

class DatabaseRebuildDialog : public QDialog
{
    Q_OBJECT
    public:
    DatabaseRebuildDialog(QWidget* parent = 0, Qt::WindowFlags f = 0);
    ~DatabaseRebuildDialog();

    bool getRebuildAll() const;
    QString getLexicon() const;

    public slots:
    void rebuildAllToggled(bool on);

    private:
    QRadioButton* rebuildAllButton;
    LexiconSelectWidget* lexiconWidget;
};

#endif // ZYZZYVA_DATABASE_REBUILD_DIALOG_H

