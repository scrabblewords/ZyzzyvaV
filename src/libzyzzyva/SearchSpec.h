//---------------------------------------------------------------------------
// SearchSpec.h
//
// A class to represent a word search specification.
//
// Copyright 2016 Twilight Century Computing.
// Copyright 2004-2012 North American SCRABBLE Players Association.
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

#ifndef ZYZZYVA_SEARCH_SPEC_H
#define ZYZZYVA_SEARCH_SPEC_H

#include "SearchCondition.h"
#include "SearchSet.h"
#include "Defs.h"
#include <QDomElement>
#include <QList>

class SearchSpec
{
    public:
    SearchSpec() : version(0), conjunction(true) { }
    ~SearchSpec() { }

    QString asString() const;
    QString asXml() const;
    QDomElement asDomElement() const;
    bool fromDomElement(const QDomElement& element);
    void optimize(const QString& lexicon);
    void update();

    int version;
    bool conjunction;
    QList<SearchCondition> conditions;
};

#endif // ZYZZYVA_SEARCH_SPEC_H
