import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/core.dart';
import '../features.dart';
import 'components/customs_declaration_item.dart';

typedef HandleEditIetm = void Function(ItemDeclaration);

class CustomsDeclarationScreen extends StatefulWidget {
  final ScreenParams params;

  const CustomsDeclarationScreen({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  _CustomsDeclarationScreenState createState() =>
      _CustomsDeclarationScreenState();
}

class _CustomsDeclarationScreenState extends State<CustomsDeclarationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _controller = Modular.get<CustomsDeclarationController>();

  final _categoryController = FormFields();
  final _descriptionController = FormFields();
  final _quantityController = FormFields();
  final _unitaryValueController = FormFieldsMoney.money();
  final _totalValueController = FormFieldsMoney.money();

  ItemDeclaration? _editDclarationItem;

  @override
  void initState() {
    _startListeenr();
    super.initState();
  }

  void _startListeenr() {
    _controller.createBoxStateStream.listen((states) async {
      if (states is CreateBoxErrorState) {
        _showErrorState(states.message);
      }

      if (states is CreateBoxSucessState) {
        _controller.navigateToHome();
      }
    });
  }

  void _showErrorState(String message) {
    ActionToErrorState(
      helper: '',
      context: context,
      message: message,
      onConfirm: _createPackage,
      buttonText: Strings.tryAgain,
    ).show();
  }

  void _onChangeToEditSection(ItemDeclaration declaration) {
    _controller.onChangedDeclarationSection(DeclarationSection.editing);
    _updateFormFields(declaration: declaration);
    _controller.onChangedForm(
      DeclarationFormType.category,
      declaration.category,
    );

    _editDclarationItem = declaration;
    _controller.setNewItemDeclaration(declaration);
  }

  bool _isValidateFields() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _addNewDeclarationItem() {
    final bool isValid = _isValidateFields();

    if (isValid) {
      _controller.addItem();

      _updateFormFields();
      _jumtoInitalScrollPosition();

      _controller.onChangedCurrentCategory(null);
    }
  }

  void _updateDeclarationItem() {
    final bool isValid = _isValidateFields();

    if (isValid && _editDclarationItem != null) {
      _controller.updateItem(_editDclarationItem!);
      _jumtoInitalScrollPosition();
      _controller.onChangedDeclarationSection(DeclarationSection.completed);
    }
  }

  void _jumtoInitalScrollPosition() {
    _scrollController.animateTo(
      0,
      curve: Curves.easeInOut,
      duration: Durations.transition,
    );
  }

  void _updateFormFields({ItemDeclaration? declaration}) {
    _controller.onChangedCurrentCategory(declaration?.category);

    _descriptionController.controller?.text = declaration?.description ?? '';
    _quantityController.controller?.text =
        declaration?.quantity?.toString() ?? '';
    _totalValueController.updateValue(declaration?.totalValue ?? 0);
    _unitaryValueController.updateValue(declaration?.unitaryValue ?? 0);
  }

  void _onFishinAddDeclarations() {
    final bool hasDesclarationsItems = _controller.hasDesclarationsItems();
    if (hasDesclarationsItems) {
      _controller.onChangedDeclarationSection(DeclarationSection.completed);
    }
  }

  void _createPackage() {
    _controller.handleFishinCreateDeclarations(
      boxList: widget.params.boxList,
      address: widget.params.address,
      dropShipping: widget.params.dropShipping,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _backButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _body(),
          controller: _scrollController,
          padding: Paddings.bodyHorizontal,
        ),
      ),
    );
  }

  Widget _backButton() {
    return StreamBuilder<CreateBoxState>(
      stream: _controller.createBoxStateStream,
      builder: (context, snapshot) {
        return Visibility(
          child: Container(),
          visible: snapshot.data is CreateBoxSucessState,
          replacement: const BackButton(
            color: AppColors.black,
          ),
        );
      },
    );
  }

  Widget _body() {
    return StreamBuilder<CreateBoxState>(
      stream: _controller.createBoxStateStream,
      builder: (context, snapshot) {
        return Visibility(
          replacement: _content(),
          child: _createBoxContent(),
          visible: snapshot.data is CreateBoxSucessState,
        );
      },
    );
  }

  Widget _content() {
    return StreamBuilder<DeclarationSection>(
      stream: _controller.declarationSectionStream,
      builder: (context, snapshot) {
        final section = snapshot.data ?? DeclarationSection.create;

        final isCompletedSection = section == DeclarationSection.completed;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerticalSpacing(10),
            _illustration(),
            const VerticalSpacing(40),
            _title(),
            Visibility(
              visible: isCompletedSection,
              child: _sectionListOrEditDeclaration(),
              replacement: _sectionCreateNewDeclaration(section),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionCreateNewDeclaration(DeclarationSection section) {
    final isEditing = section == DeclarationSection.editing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const VerticalSpacing(8),
        _warning(),
        const VerticalSpacing(Dimens.vertical),
        _declarationItems(),
        _formFields(),
        const VerticalSpacing(30),
        _actionsButtons(
          isEditing,
          isEditing ? _updateDeclarationItem : _addNewDeclarationItem,
        ),
        const VerticalSpacing(60),
      ],
    );
  }

  Widget _sectionListOrEditDeclaration() {
    return StreamBuilder<ItemDeclarationList>(
      stream: _controller.declarationsItemsStream,
      builder: (context, snapshot) {
        final list = snapshot.data ?? [];
        return Column(
          children: [
            const VerticalSpacing(48),
            Column(
              children: _generatedDeclarationItems(
                declarations: list,
                handleEditIetm: _onChangeToEditSection,
              ),
            ),
            const VerticalSpacing(24),
            _totalValueDeclared(),
            const VerticalSpacing(24),
            _finishBtn(
              text: Strings.forgotPasswordButtonTitleConfirm,
              onPressed: _createPackage,
            ),
            const VerticalSpacing(60),
          ],
        );
      },
    );
  }

  Widget _totalValueDeclared() {
    return StreamBuilder<double>(
      stream: _controller.totalDeclaredStream,
      builder: (context, snapshot) {
        final num total = snapshot.data ?? 0;
        return SizedBox(
          width: double.infinity,
          child: AutoSizeText(
            Strings.totalValueDeclared(total.formatterMoney),
            style: TextStyles.customsDeclarationStyle,
          ),
        );
      },
    );
  }

  Widget _illustration({
    String path = Svgs.tutorialFifthStep,
  }) {
    return SvgPicture.asset(
      path,
      width: Dimens.imageSize250Px,
      height: Dimens.imageSize250Px,
    );
  }

  Widget _title() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: AutoSizeText(
        Strings.customsDeclarationText[0],
        textAlign: TextAlign.center,
        style: TextStyles.customsDeclarationStyle,
      ),
    );
  }

  Widget _warning() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          Strings.customsDeclarationText[1],
          style: TextStyles.customsDeclarationStyle.copyWith(
            fontSize: 14,
            color: AppColors.grey400,
          ),
          textAlign: TextAlign.center,
        ),
        const HorizontalSpacing(4),
        const Icon(Icons.info_rounded, color: AppColors.grey400, size: 16)
      ],
    );
  }

  Widget _declarationItems() {
    return StreamBuilder<ItemDeclarationList>(
      stream: _controller.declarationsItemsStream,
      builder: (context, snapshot) {
        final list = snapshot.data ?? [];

        return Padding(
          child: Column(
            children: _generatedDeclarationItems(declarations: list),
          ),
          padding: list.isNotEmpty ? Paddings.declarationItems : Paddings.zero,
        );
      },
    );
  }

  List<Widget> _generatedDeclarationItems({
    HandleEditIetm? handleEditIetm,
    required ItemDeclarationList declarations,
  }) {
    return List.generate(declarations.length, (index) {
      return StreamBuilder<DeclarationSection>(
        stream: _controller.declarationSectionStream,
        builder: (context, snapshot) => CustomsDeclarationItem(
          index: index + 1,
          declaration: declarations[index],
          section: snapshot.data ?? DeclarationSection.create,
          onPressed: () => handleEditIetm?.call(declarations[index]),
        ),
      );
    });
  }

  Widget _formFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _categoryFormField(),
          const VerticalSpacing(Dimens.vertical),
          _descriptionFormField(),
          const VerticalSpacing(Dimens.vertical),
          _quantityFormField(),
          const VerticalSpacing(Dimens.vertical),
          _unitaryValueFormField(),
          const VerticalSpacing(Dimens.vertical),
          _totalValueFormField(),
        ],
      ),
    );
  }

  Widget _categoryFormField() {
    return StreamBuilder<String?>(
      stream: _controller.currentCateryStream,
      builder: (context, snapshot) {
        return DropdownButtonFormField<String?>(
          value: snapshot.data,
          items: _buildCategoriesItem(),
          validator: Validators.required,
          style: TextStyles.inputTextStyle,
          focusNode: _categoryController.focus,
          decoration: InputDecoration(
            border: Decorations.inputBorderForms,
            labelText: Strings.categoryLabelText,
            contentPadding: Paddings.inputContentPadding,
          ),
          iconEnabledColor: AppColors.black,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          onChanged: (value) {
            _controller.onChangedForm(
              DeclarationFormType.category,
              value ?? '',
            );

            _controller.onChangedCurrentCategory(value);
          },
          onSaved: (_) {
            _descriptionController.focus?.requestFocus();
          },
        );
      },
    );
  }

  List<DropdownMenuItem<String>> _buildCategoriesItem() {
    final categoryList = _controller.getCategoriesList();
    return categoryList.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: AutoSizeText(
          item,
          style: TextStyles.inputTextStyle,
        ),
      );
    }).toList();
  }

  Widget _descriptionFormField() {
    return TextFormField(
      maxLines: 4,
      minLines: null,
      validator: Validators.required,
      style: TextStyles.inputTextStyle,
      keyboardType: TextInputType.text,
      focusNode: _descriptionController.focus,
      controller: _descriptionController.controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
        labelText: Strings.customsDeclarationInputs[1],
      ),
      onChanged: (value) {
        _controller.onChangedForm(DeclarationFormType.description, value);
      },
      onFieldSubmitted: (_) {
        _quantityController.focus?.requestFocus();
      },
    );
  }

  Widget _quantityFormField() {
    return TextFormField(
      validator: Validators.quantity,
      style: TextStyles.inputTextStyle,
      keyboardType: TextInputType.number,
      focusNode: _quantityController.focus,
      controller: _quantityController.controller,
      decoration: InputDecoration(
        labelStyle: TextStyles.labelStyle,
        border: Decorations.inputBorderForms,
        labelText: Strings.customsDeclarationInputs[2],
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          _controller.setNumberValue(int.parse(value), isQuantity: true);
          _updateTotalValue();
        }
      },
      onFieldSubmitted: (_) {
        _unitaryValueController.focus?.requestFocus();
      },
    );
  }

  Widget _unitaryValueFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      keyboardType: TextInputType.number,
      focusNode: _unitaryValueController.focus,
      controller: _unitaryValueController.controller,
      decoration: InputDecoration(
        labelStyle: TextStyles.labelStyle,
        border: Decorations.inputBorderForms,
        labelText: Strings.customsDeclarationInputs[3],
      ),
      validator: (_) {
        return Validators.money(_unitaryValueController.numberValue);
      },
      onChanged: (value) {
        _controller.setNumberValue(_unitaryValueController.numberValue);
        _updateTotalValue();
      },
    );
  }

  void _updateTotalValue() {
    final value = _controller.calculatedTotalValue();
    _totalValueController.updateValue(value);
  }

  Widget _totalValueFormField() {
    return StreamBuilder<String?>(
      stream: _controller.declarationErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          readOnly: true,
          style: TextStyles.inputTextStyle,
          keyboardType: TextInputType.number,
          controller: _totalValueController.controller,
          validator: (_) {
            return Validators.money(_totalValueController.numberValue);
          },
          decoration: InputDecoration(
            errorText: snapshot.data,
            labelStyle: TextStyles.labelStyle,
            border: Decorations.inputBorderForms,
            labelText: Strings.customsDeclarationInputs[4],
          ),
        );
      },
    );
  }

  Widget _actionsButtons(
    bool isEditing,
    VoidCallback? onPressed,
  ) {
    return Column(
      children: [
        RoundedButton(
          isValid: true,
          onPressed: onPressed,
          title: isEditing
              ? Strings.customsDeclarationBtn[1]
              : Strings.customsDeclarationBtn.first,
        ),
        const VerticalSpacing(24),
        _finishBtn(
          text: Strings.customsDeclarationBtn.last,
          onPressed: _onFishinAddDeclarations,
        ),
      ],
    );
  }

  Widget _finishBtn({
    required String text,
    VoidCallback? onPressed,
  }) {
    return StreamBuilder<CreateBoxState>(
      stream: _controller.createBoxStateStream,
      builder: (context, snapshot) {
        return DefaultButton(
          title: text,
          isValid: true,
          onPressed: onPressed,
          isLoading: snapshot.data is CreateBoxLoadingState,
        );
      },
    );
  }

  Widget _createBoxContent() {
    return const CardCreateBox();
  }

  @override
  void dispose() {
    _controller.dispose();
    _formKey.currentState?.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _unitaryValueController.dispose();
    _totalValueController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
