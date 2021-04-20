/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:receipt_manager/domain/usecase/receipt_usecase.dart';

class ServerSettingsPresenter extends Presenter {
  Function? getReceiptsOnNext;
  Function? getReceiptsOnComplete;
  Function? getReceiptsOnError;

  final GetReceiptUseCase getReceiptUseCase;
  ServerSettingsPresenter(usersRepo)
      : getReceiptUseCase = GetReceiptUseCase(usersRepo);

  void getReceipts() {
    getReceiptUseCase.execute(
        GetReceiptUseCaseObserver(this), GetReceiptUseCaseParams());
  }

  @override
  void dispose() {
    getReceiptUseCase.dispose();
  }
}

class GetReceiptUseCaseObserver extends Observer<GetReceiptUseCaseResponse> {
  final ServerSettingsPresenter presenter;
  GetReceiptUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getReceiptsOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getReceiptsOnError!(e);
  }

  @override
  void onNext(response) {
    presenter.getReceiptsOnNext!(response?.receipts);
  }
}
